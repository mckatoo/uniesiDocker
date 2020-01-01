#!/bin/bash
cd /app/api
npm install
cd /app/api
npm run migrate
cd /app/api
npm start
