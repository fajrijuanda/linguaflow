from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    # Language Enums
    LANG_EN = 'en'
    LANG_ID = 'id'
    
    SYSTEM_LANG_CHOICES = [
        (LANG_EN, 'English'),
        (LANG_ID, 'Indonesian'),
    ]

    COURSE_KR = 'KR'
    COURSE_JP = 'JP'
    COURSE_CN = 'CN'
    COURSE_EN = 'EN'
    COURSE_ID = 'ID'

    LEARNING_LANG_CHOICES = [
        (COURSE_KR, 'Korean'),
        (COURSE_JP, 'Japanese'),
        (COURSE_CN, 'Chinese'),
        (COURSE_EN, 'English'),
        (COURSE_ID, 'Indonesian'),
    ]

    # Fields
    email = models.EmailField(unique=True)
    preferred_system_lang = models.CharField(
        max_length=2, 
        choices=SYSTEM_LANG_CHOICES, 
        default=LANG_EN
    )
    current_learning_lang = models.CharField(
        max_length=2, 
        choices=LEARNING_LANG_CHOICES, 
        default=COURSE_EN
    )
    
    # Gamification
    xp = models.PositiveIntegerField(default=0)
    streak = models.PositiveIntegerField(default=0)
    last_study_date = models.DateField(null=True, blank=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username'] # username is still required by AbstractUser but we login with email

    def __str__(self):
        return self.email
