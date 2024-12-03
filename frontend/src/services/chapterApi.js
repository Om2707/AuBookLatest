// src/services/chaptersApi.js

import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';

export const chaptersApi = createApi({
  reducerPath: 'chaptersApi',
  baseQuery: fetchBaseQuery({ baseUrl: 'https://2ad7-47-247-94-66.ngrok-free.app/api/' }),
  endpoints: (builder) => ({
    getChapters: builder.query({
      query: () => 'chapters/',
    }),
  }),
});

export const { useGetChaptersQuery } = chaptersApi;
