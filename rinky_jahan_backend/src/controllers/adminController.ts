import { Request, Response } from 'express';
import { supabase } from '../config/supabase';

/**
 * Endpoint: GET /api/admin/bookings
 */
export const getAllBookings = async (req: Request, res: Response): Promise<void> => {
    try {
        const { data: bookings, error } = await supabase
            .from('bookings')
            .select(`
                *,
                users (name, phone),
                services (title),
                stylists (name)
            `)
            .order('booking_date', { ascending: true })
            .order('time_slot', { ascending: true });

        if (error) {
             console.error('[ADMIN ERROR - getAllBookings]', error);
             res.status(500).json({ error: 'Failed to fetch all bookings' });
             return;
        }

        res.status(200).json({ status: 'success', data: bookings });
    } catch (error: any) {
        console.error('[ADMIN ERROR - getAllBookings]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

/**
 * Endpoint: POST /api/admin/bookings
 * Description: Creates a confirmed booking for walk-ins directly.
 */
export const createOfflineBooking = async (req: Request, res: Response): Promise<void> => {
    try {
        const { user_id, service_id, stylist_id, booking_date, time_slot, total_amount, special_notes } = req.body;

        if (!user_id || !service_id || !booking_date || !time_slot || !total_amount) {
            res.status(400).json({ error: 'Missing required booking parameters' });
            return;
        }

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
                status: 'confirmed' // Offline bookings skip payment verification
            }])
            .select()
            .single();

        if (error) {
            console.error('[ADMIN ERROR - createOfflineBooking]', error);
            res.status(500).json({ error: 'Failed to create offline booking' });
            return;
        }

        res.status(201).json({ status: 'success', message: 'Offline booking created', data: booking });
    } catch (error: any) {
        console.error('[ADMIN ERROR - createOfflineBooking]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};
