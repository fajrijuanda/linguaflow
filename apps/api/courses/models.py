from django.db import models

class Course(models.Model):
    # KR, JP, CN, etc.
    code = models.CharField(max_length=2, primary_key=True)
    name = models.CharField(max_length=50)
    flag_icon = models.CharField(max_length=255, help_text="URL or Asset Path")
    
    # Theme configuration
    # Stored as JSON: {"primary": "#...", "accent": "#..."}
    theme_colors = models.JSONField(default=dict)

    def __str__(self):
        return self.name

class Unit(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='units')
    title = models.CharField(max_length=100)
    order = models.PositiveIntegerField()
    description = models.TextField(blank=True)

    class Meta:
        ordering = ['order']

    def __str__(self):
        return f"{self.course.code} - {self.title}"

class Lesson(models.Model):
    unit = models.ForeignKey(Unit, on_delete=models.CASCADE, related_name='lessons')
    title = models.CharField(max_length=100)
    order = models.PositiveIntegerField()
    
    class Meta:
        ordering = ['order']

    def __str__(self):
        return self.title

class Exercise(models.Model):
    lesson = models.ForeignKey(Lesson, on_delete=models.CASCADE, related_name='exercises')
    
    TYPE_CHOICES = [
        ('flashcard', 'Flashcard'),
        ('quiz', 'Quiz Choice'),
        ('match', 'Match Pairs'),
    ]
    
    type = models.CharField(max_length=20, choices=TYPE_CHOICES)
    question = models.TextField() # Or JSON if complex
    answer = models.TextField() # Or JSON
    options = models.JSONField(null=True, blank=True) # For multiple choice
    order = models.PositiveIntegerField()

    class Meta:
        ordering = ['order']

    def __str__(self):
        return f"{self.lesson.title} - Q{self.order}"
