import { Request, Response } from 'express';
import { supabase } from '../config/supabase';
// import { sendOTP, verifyOTP } from '../services/msg91Service'; // Future integration

/**
 * Endpoint: POST /api/auth/send-otp
 * Body: { "phone": "+91XXXXXXXXXX" }
 */
export const sendOtp = async (req: Request, res: Response): Promise<void> => {
    try {
        const { phone } = req.body;

        if (!phone) {
            res.status(400).json({ error: 'Phone number is required' });
            return;
        }

        // TODO: Call actual MSG91 service logic here.
        // For development, we assume OTP is 1234.
        console.log(`[AUTH] Development mode: Mock OTP sent to ${phone}`);

        res.status(200).json({ 
            status: 'success', 
            message: 'OTP sent successfully (Mocked for Dev)',
            test_otp: '1234'
        });
    } catch (error: any) {
        console.error('[AUTH ERROR - sendOtp]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

/**
 * Endpoint: POST /api/auth/verify-otp
 * Body: { "phone": "+91XXXXXXXXXX", "otp": "1234" }
 */
export const verifyOtp = async (req: Request, res: Response): Promise<void> => {
    try {
        const { phone, otp } = req.body;

        if (!phone || !otp) {
            res.status(400).json({ error: 'Phone and OTP are required' });
            return;
        }

        // Mock verification
        if (otp !== '1234') {
            res.status(401).json({ error: 'Invalid OTP' });
            return;
        }

        // If OTP is valid, interact with Supabase Users table.
        // (Note: Supabase might throw errors if table doesn't exist yet, we catch those).
        let { data: user, error: fetchError } = await supabase
            .from('users')
            .select('*')
            .eq('phone', phone)
            .single();

        if (fetchError && fetchError.code !== 'PGRST116') { // PGRST116 is 'not found'
             res.status(500).json({ error: 'Database error fetching user' });
             return;
        }

        // If user doesn't exist, create a new one
        if (!user) {
            const { data: newUser, error: insertError } = await supabase
                .from('users')
                .insert([{ phone }])
                .select()
                .single();

            if (insertError) {
                 res.status(500).json({ error: 'Failed to create new user record' });
                 return;
            }
            user = newUser;
        }

        res.status(200).json({
            status: 'success',
            message: 'OTP verified successfully',
            user: user
        });

    } catch (error: any) {
        console.error('[AUTH ERROR - verifyOtp]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};
