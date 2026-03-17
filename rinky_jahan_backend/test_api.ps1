# Rinky Jahan Makeover - API Endpoints Testing Script (PowerShell)
# Run these commands step-by-step in your terminal to verify functionality.

$BASE_URL = "http://localhost:3000/api"

echo "`n--- 1. Health Check ---"
Invoke-RestMethod -Uri "http://localhost:3000/" -Method Get

echo "`n--- 2. Auth: Send OTP ---"
Invoke-RestMethod -Uri "$BASE_URL/auth/send-otp" -Method Post -ContentType "application/json" -Body '{"phone": "+919876543210"}'

echo "`n--- 3. Auth: Verify OTP ---"
# Note: Fails cleanly if Supabase isn't hooked up yet, which validates routing.
try {
    Invoke-RestMethod -Uri "$BASE_URL/auth/verify-otp" -Method Post -ContentType "application/json" -Body '{"phone": "+919876543210", "otp": "1234"}'
} catch {
    $_.Exception.Response
}

echo "`n--- 4. Catalog: Get Services ---"
try {
    Invoke-RestMethod -Uri "$BASE_URL/catalog/services" -Method Get
} catch {
    $_.Exception.Response
}

echo "`n--- 5. Admin: Get Bookings ---"
try {
    Invoke-RestMethod -Uri "$BASE_URL/admin/bookings" -Method Get
} catch {
    $_.Exception.Response
}
