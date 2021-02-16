"""wofemtech_django URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from wofemtech_django import settings

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('wofemtech.urls')),
	path("stripe/", include("djstripe.urls", namespace="djstripe")),
]+static(settings.development.MEDIA_URL, document_root=settings.development.MEDIA_ROOT)
# ]+static(settings.production.MEDIA_URL, document_root=settings.production.MEDIA_ROOT)

