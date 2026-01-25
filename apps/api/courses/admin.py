from django.contrib import admin
from .models import Course, Unit, Lesson, Exercise

class LessonInline(admin.TabularInline):
    model = Lesson
    extra = 1

class UnitInline(admin.TabularInline):
    model = Unit
    extra = 1
    show_change_link = True

@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ['code', 'name']
    inlines = [UnitInline]

@admin.register(Unit)
class UnitAdmin(admin.ModelAdmin):
    list_display = ['title', 'course', 'order']
    list_filter = ['course']
    inlines = [LessonInline]

@admin.register(Lesson)
class LessonAdmin(admin.ModelAdmin):
    list_display = ['title', 'unit', 'order']
    list_filter = ['unit__course']

@admin.register(Exercise)
class ExerciseAdmin(admin.ModelAdmin):
    list_display = ['type', 'lesson', 'order']
