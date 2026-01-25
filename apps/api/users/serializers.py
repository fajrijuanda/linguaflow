from rest_framework import serializers
from django.contrib.auth import get_user_model

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'preferred_system_lang', 'current_learning_lang', 'xp', 'streak']
        read_only_fields = ['xp', 'streak']
