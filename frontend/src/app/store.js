import { configureStore } from '@reduxjs/toolkit';
import { chaptersApi } from '../services/chapterApi';

export const store = configureStore({
  reducer: {
    [chaptersApi.reducerPath]: chaptersApi.reducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat(chaptersApi.middleware),
});
