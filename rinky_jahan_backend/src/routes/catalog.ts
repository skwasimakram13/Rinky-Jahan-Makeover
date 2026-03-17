import { Router } from 'express';
import { getServices, getProducts, getStylists } from '../controllers/catalogController';

const router = Router();

router.get('/services', getServices);
router.get('/products', getProducts);
router.get('/stylists', getStylists);

export default router;
