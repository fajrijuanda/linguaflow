from rest_framework import serializers
from .models import Course, Unit, Lesson, Exercise

class ExerciseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exercise
        fields = ['id', 'type', 'question', 'answer', 'options', 'order']

class LessonSerializer(serializers.ModelSerializer):
    exercises = ExerciseSerializer(many=True, read_only=True)

    class Meta:
        model = Lesson
        fields = ['id', 'title', 'order', 'exercises']

class UnitSerializer(serializers.ModelSerializer):
    lessons = LessonSerializer(many=True, read_only=True)

    class Meta:
        model = Unit
        fields = ['id', 'title', 'description', 'order', 'lessons']

class CourseSerializer(serializers.ModelSerializer):
    units = UnitSerializer(many=True, read_only=True)

    class Meta:
        model = Course
        fields = ['code', 'name', 'flag_icon', 'theme_colors', 'units']
