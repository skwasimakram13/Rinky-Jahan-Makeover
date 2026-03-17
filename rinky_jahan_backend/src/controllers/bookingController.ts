import { Request, Response } from 'express';
import { supabase } from '../config/supabase';
// import Razorpay from 'razorpay'; 

/**
 * Endpoint: POST /api/bookings
 * Body: { "user_id": UUID, "service_id": UUID, "stylist_id": UUID, "booking_date": "YYYY-MM-DD", "time_slot": "10:00 AM", "total_amount": 250.00 }
 */
export const createBooking = async (req: Request, res: Response): Promise<void> => {
    try {
        const { user_id, service_id, stylist_id, booking_date, time_slot, total_amount, special_notes } = req.body;

        // 1. Validate inputs (simplified)
        if (!user_id || !service_id || !booking_date || !time_slot || !total_amount) {
            res.status(400).json({ error: 'Missing required booking parameters' });
            return;
        }

        // Check for booking conflicts
        const { data: existingBooking, error: conflictError } = await supabase
            .from('bookings')
            .select('id')
            .eq('stylist_id', stylist_id)
            .eq('booking_date', booking_date)
            .eq('time_slot', time_slot)
            .neq('status', 'cancelled') // Assuming cancelled bookings free up the slot
            .limit(1)
            .maybeSingle();

        if (conflictError) {
             console.error('[BOOKING ERROR - DB Conflict Check]', conflictError);
             res.status(500).json({ error: 'Failed to verify slot availability' });
             return;
        }
        
        if (existingBooking) {
            res.status(409).json({ error: 'This time slot is already booked for the selected stylist.' });
            return;
        }

        // 2. Insert into Supabase with 'pending' status
        const { data: booking, error } = await supabase
            .from('bookings')
            .insert([{
                user_id,
                service_id,
                stylist_id,
                booking_date,
                time_slot,
                total_amount,
                special_notes,
                status: 'pending'
            }])
            .select()
            .single();

        if (error) {
            console.error('[BOOKING ERROR - DB Insert]', error);
            res.status(500).json({ error: 'Failed to create booking in database' });
            return;
        }

        // 3. (Future) Generate Razorpay Order
        // const razorpay = new Razorpay({ key_id: '...', key_secret: '...' });
        // const order = await razorpay.orders.create({ amount: total_amount * 100, currency: 'INR' });
        // Update booking with razorpay_order_id = order.id

        const mockRazorpayOrderId = `order_mock_${Date.now()}`;

        res.status(201).json({
            status: 'success',
            message: 'Booking created successfully',
            data: {
                booking,
                razorpay_order_id: mockRazorpayOrderId,
                amount_in_paise: total_amount * 100
            }
        });
    } catch (error: any) {
        console.error('[BOOKING ERROR - createBooking]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

/**
 * Endpoint: GET /api/bookings/user/:user_id
 */
export const getUserBookings = async (req: Request, res: Response): Promise<void> => {
    try {
        const { user_id } = req.params;

        // Typically, we would join with services and stylists tables here to get populated data.
        const { data: bookings, error } = await supabase
            .from('bookings')
            .select(`
                *,
                services (title, image_url),
                stylists (name)
            `)
            .eq('user_id', user_id)
            .order('booking_date', { ascending: false });

        if (error) {
             console.error('[BOOKING ERROR - getUserBookings]', error);
             res.status(500).json({ error: 'Failed to fetch user bookings' });
             return;
        }

        res.status(200).json({ status: 'success', data: bookings });
    } catch (error: any) {
        console.error('[BOOKING ERROR - getUserBookings]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

/**
 * Endpoint: PATCH /api/bookings/:id/status
 * Body: { "status": "confirmed" | "completed" | "cancelled" | "no_show" }
 */
export const updateBookingStatus = async (req: Request, res: Response): Promise<void> => {
    try {
        const { id } = req.params;
        const { status } = req.body;

        const { data: booking, error } = await supabase
            .from('bookings')
            .update({ status, updated_at: new Date().toISOString() })
            .eq('id', id)
            .select()
            .single();

        if (error) {
             console.error('[BOOKING ERROR - updateStatus]', error);
             res.status(500).json({ error: 'Failed to update booking status' });
             return;
        }

        res.status(200).json({ status: 'success', message: `Booking marked as ${status}`, data: booking });
    } catch (error: any) {
        console.error('[BOOKING ERROR - updateStatus]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};
