#!/bin/bash

npx prisma generate
npx prisma migrate dev --name initial
npm start

