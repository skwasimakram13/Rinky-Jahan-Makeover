import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

let supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';

if (!supabaseUrl.startsWith('http')) {
  console.warn('⚠️  Invalid or missing SUPABASE_URL in .env (Must start with http/https). Using mock URL to prevent local crash.');
  supabaseUrl = 'http://localhost:8000'; // Dummy URL fallback
}

if (!supabaseKey) {
  console.warn('⚠️  Supabase environment variables are missing. Ensure SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are set.');
}

export const supabase = createClient(supabaseUrl, supabaseKey);
