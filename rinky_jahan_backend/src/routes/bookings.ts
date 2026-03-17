import { Router } from 'express';
import { createBooking, getUserBookings, updateBookingStatus } from '../controllers/bookingController';

const router = Router();

router.post('/', createBooking);
router.get('/user/:user_id', getUserBookings);
router.patch('/:id/status', updateBookingStatus);

export default router;
