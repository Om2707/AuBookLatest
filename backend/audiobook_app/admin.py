from django.contrib import admin
from .models import Role, Samhita, Book, Chapter, Section, AudioFile, Shlok, Symptom, Disease, ShlokSymptom, ShlokDisease, Playlist, PlaylistShlok

admin.site.register(Role)
admin.site.register(Samhita)
admin.site.register(Book)
admin.site.register(Chapter)
admin.site.register(Section)
admin.site.register(AudioFile)
admin.site.register(Shlok)
admin.site.register(Symptom)
admin.site.register(Disease)
admin.site.register(ShlokSymptom)
admin.site.register(ShlokDisease)
admin.site.register(Playlist)
admin.site.register(PlaylistShlok)
