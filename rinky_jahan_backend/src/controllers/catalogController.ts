import { Request, Response } from 'express';
import { supabase } from '../config/supabase';

/**
 * Endpoint: GET /api/catalog/services
 */
export const getServices = async (req: Request, res: Response): Promise<void> => {
    try {
        const { data: services, error } = await supabase
            .from('services')
            .select('*')
            .order('created_at', { ascending: false });

        if (error) {
            console.error('[CATALOG ERROR - getServices from DB]', error);
            res.status(500).json({ error: 'Failed to fetch services from database' });
            return;
        }

        res.status(200).json({ status: 'success', data: services });
    } catch (error: any) {
        console.error('[CATALOG ERROR - getServices]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

/**
 * Endpoint: GET /api/catalog/products
 */
export const getProducts = async (req: Request, res: Response): Promise<void> => {
    try {
        const { data: products, error } = await supabase
            .from('products')
            .select('*')
            .order('created_at', { ascending: false });

        if (error) {
            console.error('[CATALOG ERROR - getProducts from DB]', error);
            res.status(500).json({ error: 'Failed to fetch products from database' });
            return;
        }

        res.status(200).json({ status: 'success', data: products });
    } catch (error: any) {
        console.error('[CATALOG ERROR - getProducts]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

/**
 * Endpoint: GET /api/catalog/stylists
 */
export const getStylists = async (req: Request, res: Response): Promise<void> => {
    try {
        const { data: stylists, error } = await supabase
            .from('stylists')
            .select('*')
            .order('name', { ascending: true });

        if (error) {
            console.error('[CATALOG ERROR - getStylists from DB]', error);
            res.status(500).json({ error: 'Failed to fetch stylists from database' });
            return;
        }

        res.status(200).json({ status: 'success', data: stylists });
    } catch (error: any) {
        console.error('[CATALOG ERROR - getStylists]', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};
