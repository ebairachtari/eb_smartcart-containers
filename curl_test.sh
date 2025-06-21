#!/bin/bash

# Χρώματα για output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}1. 🔐 Κάνουμε login...${NC}"

# Κάνουμε login και παίρνουμε το token
LOGIN_RESPONSE=$(curl -s -X POST http://localhost:5000/auth/login \
  -H "Content-Type: application/json" \
  -d '{
        "email": "demo_user@unipi.gr",
        "password": "qqQQ11!!"
      }')

TOKEN=$(echo $LOGIN_RESPONSE | python3 -c "import sys, json; print(json.load(sys.stdin).get('access_token', ''))")

if [ -z "$TOKEN" ]; then
  echo -e "${RED}❌ Login failed. Response:${NC}"
  echo $LOGIN_RESPONSE
  exit 1
fi

echo -e "${GREEN}✅ Login επιτυχές. Token:${NC} $TOKEN"

# Κλήση σε protected endpoint
echo -e "\n${GREEN}2. 👤 Δοκιμή /profile...${NC}"

curl -s -X GET http://localhost:5000/profile \
  -H "Authorization: Bearer $TOKEN"

# Κλήση στο ML service
echo -e "\n\n${GREEN}3. 🧠 Δοκιμή ML service /predict...${NC}"

curl -s -X POST http://localhost:5001/predict \
  -H "Content-Type: application/json" \
  -d '{
        "basket": [1, 0]
      }'

echo -e "\n\n${GREEN}🎯 Τέλος curl tests${NC}"
