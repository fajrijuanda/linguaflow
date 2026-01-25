from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    model = CustomUser
    list_display = ['email', 'username', 'preferred_system_lang', 'current_learning_lang', 'xp', 'is_staff']
    fieldsets = UserAdmin.fieldsets + (
        (None, {'fields': ('preferred_system_lang', 'current_learning_lang', 'xp', 'streak')}),
    )
