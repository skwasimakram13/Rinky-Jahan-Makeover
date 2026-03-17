import { Router } from 'express';
import { getAllBookings, createOfflineBooking } from '../controllers/adminController';

const router = Router();

router.get('/bookings', getAllBookings);
router.post('/bookings', createOfflineBooking);

export default router;
