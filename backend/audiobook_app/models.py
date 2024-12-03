from django.db import models
from django.contrib.auth.models import User

# Role Model
class Role(models.Model):
    role_name = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.role_name

# Samhita Model
class Samhita(models.Model):
    samhita_name = models.CharField(max_length=255)
    image_path = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.samhita_name

# Book Model
class Book(models.Model):
    samhita = models.ForeignKey(Samhita, on_delete=models.CASCADE)
    book_name = models.CharField(max_length=255)
    book_number = models.IntegerField()
    image_path = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.book_name

# Chapter Model
class Chapter(models.Model):
    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    chapter_name = models.CharField(max_length=255)
    chapter_number = models.IntegerField()
    image_path = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.chapter_name

# Section Model
class Section(models.Model):
    chapter = models.ForeignKey(Chapter, on_delete=models.CASCADE)
    section_name = models.CharField(max_length=255)
    section_number = models.IntegerField()
    image_path = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.section_name

# Audio File Model
class AudioFile(models.Model):
    file_path = models.CharField(max_length=255)
    file_format = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.file_path

# Shlok Model
class Shlok(models.Model):
    chapter = models.ForeignKey(Chapter, on_delete=models.CASCADE, null=True, blank=True)
    section = models.ForeignKey(Section, on_delete=models.CASCADE, null=True, blank=True)
    shlok_number = models.IntegerField()
    shlok_text = models.TextField()
    shlok_audio = models.ForeignKey(AudioFile, related_name='shlok_audio', on_delete=models.CASCADE)
    explanation_audio = models.ForeignKey(AudioFile, related_name='explanation_audio', on_delete=models.CASCADE, null=True, blank=True)
    explanation_text_hindi = models.TextField(null=True, blank=True)
    explanation_text_english = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return f'Shlok {self.shlok_number}'

# Symptom Model
class Symptom(models.Model):
    symptom_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.symptom_name

# Disease Model
class Disease(models.Model):
    disease_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.disease_name

# Many-to-Many relationships
class ShlokSymptom(models.Model):
    shlok = models.ForeignKey(Shlok, on_delete=models.CASCADE)
    symptom = models.ForeignKey(Symptom, on_delete=models.CASCADE)

class ShlokDisease(models.Model):
    shlok = models.ForeignKey(Shlok, on_delete=models.CASCADE)
    disease = models.ForeignKey(Disease, on_delete=models.CASCADE)

# Playlist Model
class Playlist(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    playlist_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    modified_at = models.DateTimeField(auto_now=True)
    modified_by = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return self.playlist_name

# PlaylistShlok Model
class PlaylistShlok(models.Model):
    playlist = models.ForeignKey(Playlist, on_delete=models.CASCADE)
    shlok = models.ForeignKey(Shlok, on_delete=models.CASCADE)
