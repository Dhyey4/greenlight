from django.contrib.auth.decorators import login_required
from django.urls import path, include
from .views import *
from wofemtech import views

app_name = 'wofemtech'

urlpatterns = [
	path('contact-us/',ContactUs.as_view(), name='contact-us'),
	path('features/', Features.as_view(), name='features'),
	path('',Index.as_view(), name='index'),
	path('meetings/',Meetings.as_view(),name='meetings'),
	# path('pricing/',views.pricing,name='pricing'),
	path('pricing/',pricing.as_view(),name="pricing"),
	path('teams/',Teams.as_view(),name='teams'),
	path('tutorials/',Tutorials.as_view(),name='tutorials'),
	path('login/',LogIn.as_view(),name='login'),
	path('test',test,name='test'),
	path('logout', LogOut.as_view(), name="logout"),
	path('register',Register.as_view(), name="register"),
	path('checkout',views.checkout,name='checkout'),
	path("create-sub", views.create_sub, name="create sub"),
	path("complete", views.complete, name="complete"),
	path('api/cart/', cart.as_view(), name='cart'),
	path('api/clearcart',ClearCart.as_view(), name="clearcart"),
	path('payment',login_required(StartPayment.as_view()), name="payment"),
	path('profile',Profile.as_view(),name='profile'),
	path('forgotpassword/', ForgetpasswordView.as_view(), name='forgotpassword'),
    path('verification/<uidb64>/<token>/', PasswordChangeView.as_view(), name='changepassword'),
    path('demo',Demo.as_view(),name='demo'),
    path('demo_success',DemoSuccess.as_view(),name='demo_success'),
    path('file_load_view',views.file_load_view,name='file_load_view'),
    path('subscribe/', views.subscribe, name = "subscribe"),
    path('api/password_change/',UpdatePass.as_view(),name='password_change'),
    path('api/update_profile/',UpdateProfile.as_view(),name='update_profile'),
    path('api/cancel_subscription/',cancel_subscription.as_view(),name='cancel_subscription'),
    path('api/SendContactUsMail/',SendContactUsMail.as_view(),name='SendContactUsMail'),
    path('api/demo_mail/',DemoMail.as_view(),name='demo_mail'),
    path('api/save_user_data/',UserDataForm.as_view(),name='save_user_data'),

]