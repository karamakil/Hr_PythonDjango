from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from hr_application.models import Employee
from django.forms.models import BaseInlineFormSet


class RequiredInlineFormSet(BaseInlineFormSet):
    """
    Generates an inline formset that is required
    """
    def _construct_form(self, i, **kwargs):
        """
        Override the method to change the form attribute empty_permitted
        """
        form = super(RequiredInlineFormSet, self)._construct_form(i, **kwargs)
        form.empty_permitted = False
        return form


class UserCreateForm(UserCreationForm):

    class Meta:
        model = Employee
        fields = ('title', 'phone' , 'department', )


class ProfileInline(admin.StackedInline):
    model = Employee
    can_delete = False
    verbose_name_plural = 'Profile'
    fk_name = 'user'
    formset = RequiredInlineFormSet


class UserAdmin(UserAdmin):
    inlines = (ProfileInline,)

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('first_name', 'last_name', 'username', 'password1', 'password2',),
        }),
    )


admin.site.unregister(User)
admin.site.register(User, UserAdmin)