from django.shortcuts import render, redirect
from django.views.generic import TemplateView, RedirectView
from django.contrib.auth import authenticate, login, logout
from django.views.decorators.csrf import csrf_exempt
from .models import *
from django.contrib.auth.hashers import check_password
import bcrypt
import random
import string
import stripe
from django.conf import settings
import json
from django.http import JsonResponse
from django.http import HttpResponse, HttpResponseRedirect
from django.db.models import Sum
from django.urls import reverse
from djstripe.models import *
from django.contrib.auth.decorators import login_required
from djstripe import webhooks
from django.core.mail import send_mail
import djstripe
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.sites.shortcuts import get_current_site
from django.views import View
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from wofemtech.token import account_activation_token
from django.template.loader import render_to_string
import csv
import requests
from django.contrib import messages
import mailchimp
import threading
from .utils import SendSubscribeMail
import os
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail
import datetime
import pytz
from django.utils import timezone
from django.utils.dateparse import parse_date
from datetime import datetime
import time


# Create your views here.

stripe.api_key = settings.STRIPE_PRIVATE_KEY

MAILCHIMP_API_KEY = settings.MAILCHIMP_API_KEY
MAILCHIMP_DATA_CENTER = settings.MAILCHIMP_DATA_CENTER
MAILCHIMP_EMAIL_LIST_ID = settings.MAILCHIMP_EMAIL_LIST_ID

api_url = f'https://{MAILCHIMP_DATA_CENTER}.api.mailchimp.com/3.0'
members_endpoint = f'{api_url}/lists/{MAILCHIMP_EMAIL_LIST_ID}/members'



# def welcome_mail(email_data=None, TEMP_ID=None):
#     message = Mail(
#         from_email="hello@wofemtech.com",
#         to_emails=["thakkarmeet88@gmail.com"],
#         subject='Welcome to Wofemtech',
#     )
#     # pass custom values for our HTML placeholders
#     if not TEMP_ID:
#         message.template_id = "d-b8bde7c787d44339acba79ef4d0ded5b"
#         message.dynamic_template_data = {
#             # 'plan_name': name,
#             # 'password': password,
#             # 'user_id': pf,
#         }
#     else:
#         message.template_id = TEMP_ID
#         message.dynamic_template_data = {
#             # 'name': name,
#             # 'msg': msg,
#             # 'user_id': pf
#         }

#     # create our sendgrid client object, pass it our key, then send and return our response objects
#     try:
#         # dhyey key test
#         # sg = SendGridAPIClient('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')
#         # wofemtech key
#         sg = SendGridAPIClient("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")
#         response = sg.send(message)
#         code, body, headers = response.status_code, response.body, response.headers
#         print("Response code:", code)
#         print("Response headers:", headers)
#         print("Response body:", body)
#         print("Dynamic Messages Sent!")
#     except Exception as e:
#         print("Error: {0}".format(e))

def file_load_view(request):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachement; filename="data.csv"'

    writer = csv.writer(response)
    writer.writerow(['Name', 'Email'])

    Datas = Users.objects.values('name','email')

    # Note: we convert the students query set to a values_list as the writerow expects a list/tuple       
    DATA = Datas.values_list('name', 'email')

    for d in DATA:
        writer.writerow(d)

    return response

def welcome_mail(email_data=None, TEMP_ID=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Welcome to Wofemtech',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-b8bde7c787d44339acba79ef4d0ded5b"
        message.dynamic_template_data = {
            # 'plan_name': name,
            # 'password': password,
            # 'user_id': pf,
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
        print("welcome_mail")
    except Exception as e:
        print("Error: {0}".format(e))


def after_3days_send_mail(email_data=None, TEMP_ID=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Welcome to Wofemtech',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-b8bde7c787d44339acba79ef4d0ded5b"
        message.dynamic_template_data = {
            # 'plan_name': name,
            # 'password': password,
            # 'user_id': pf,
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
        print("after 3 days mail")
    except Exception as e:
        print("Error: {0}".format(e))

def after_9days_send_mail(email_data=None, TEMP_ID=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Free Trial Expiring In 4 Days',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-b1b30ab5ebb945da826b27f6261fee4d"
        message.dynamic_template_data = {
            # 'plan_name': name,
            # 'password': password,
            # 'user_id': pf,
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
        print("after 9 days mail")
    except Exception as e:
        print("Error: {0}".format(e))


def after_13days_send_mail(email_data=None, TEMP_ID=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Free Trial Expiring In 2 Days.',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-0b130c8f1b88486b82e8b1ebff384c89"
        message.dynamic_template_data = {
            # 'plan_name': name,
            # 'password': password,
            # 'user_id': pf,
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
        print("after 13 days mail")
    except Exception as e:
        print("Error: {0}".format(e))


def free_expired_send_mail(email_data=None, TEMP_ID=None, date_time=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Free Trial Expired',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-dfb12ee09ebe4edfa91d2813cdccc9a9"
        message.dynamic_template_data = {
            'date_time': date_time,
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
        print("free expired mail")
    except Exception as e:
        print("Error: {0}".format(e))

def after_subscription_send_mail(plan_name=None, email_data=None, TEMP_ID=None, duration=None,start_date=None, expiry_date=None, plan_amount=None, plan_features=None,plan_currency=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Wofemtech Subscription Succeessfull',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-5ef0675ab435491c95ac1b1dc6af6c8e"
        message.dynamic_template_data = {
            'plan_name': plan_name,
            'duration': duration,
            'start_date':start_date,
            'expiry_date': expiry_date,
            'plan_amount': plan_amount,
            'plan_features': plan_features,
            'plan_currency':plan_currency,
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
    except Exception as e:
        print("Error: {0}".format(e))


def send_mail_before_subscription_expired(email_data=None, TEMP_ID=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Welcome to Wofemtech',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-b8bde7c787d44339acba79ef4d0ded5b"
        message.dynamic_template_data = {
            # 'plan_name': name,
            # 'password': password,
            # 'user_id': pf,
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
    except Exception as e:
        print("Error: {0}".format(e))


def send_mail_plan_expired(plan_name=None, email_data=None, TEMP_ID=None, duration=None,start_date=None, expiry_date=None, plan_amount=None, plan_features=None,plan_currency=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Subscription Expired',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-3adc20131fab4e3b86c5ceb4f1df3660 "
        message.dynamic_template_data = {
            'plan_name': plan_name,
            'duration': duration,
            'start_date':start_date,
            'expiry_date': expiry_date,
            'plan_amount': plan_amount,
            'plan_features': plan_features,
            'plan_currency':plan_currency,
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
    except Exception as e:
        print("Error: {0}".format(e))


def send_forgot_password_mail(username=None,domain=None,uidb64=None,token=None,email_data=None,TEMP_ID=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Forgot password',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-7be547f330a64950a0638ee4dd989f35"
        message.dynamic_template_data = {
            'username': username,
            'domain': domain,
            'uidb64':uidb64,
            'token': token,
            
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
    except Exception as e:
        print("Error: {0}".format(e))

def contact_us_mail(name=None,email=None,phone_number=None,priority=None,company=None,address=None,issue=None,contact_message=None,TEMP_ID=None,email_data=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Contact Us',
    )
    # pass custom values for our HTML placeholders
    message.template_id = "d-c00b4db931f44f88aa81fe6d053ad8c3"
    message.dynamic_template_data = {
        'name': name,
        'email': email,
        'phone_number': phone_number,
        'priority' : priority,
        'company': company,
        'address': address,
        'issue': issue,
        'message':contact_message,
        
    }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
    except Exception as e:
        print("Error: {0}".format(e))

def request_demo_mail(name=None,email=None,phone_number=None,country=None,company_name=None,total_emp=None,pdate=None,ptime=None,demo_message=None,TEMP_ID=None,email_data=None):
    message = Mail(
        from_email="hello@wofemtech.com",
        to_emails=[email_data],
        subject='Request For A demo',
    )
    # pass custom values for our HTML placeholders
    if not TEMP_ID:
        message.template_id = "d-b06731d4c5d04c72949c43191f0375a9"
        message.dynamic_template_data = {
            'name': name,
            'email': email,
            'message':demo_message,
            'phone_number':phone_number,
            'country':country,
            'company_name':company_name,
            'total_emp':total_emp,
            'pdate':pdate,
            'ptime':ptime,
            
        }
    else:
        message.template_id = TEMP_ID
        message.dynamic_template_data = {
            # 'name': name,
            # 'msg': msg,
            # 'user_id': pf
        }

    # create our sendgrid client object, pass it our key, then send and return our response objects
    try:
        # dhyey key test
        # sg = SendGridAPIClient('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')
        # wofemtech key
        sg = SendGridAPIClient("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")
        response = sg.send(message)
        code, body, headers = response.status_code, response.body, response.headers
        print("Response code:", code)
        print("Response headers:", headers)
        print("Response body:", body)
        print("Dynamic Messages Sent!")
    except Exception as e:
        print("Error: {0}".format(e))


def test(request):
    password = "admin"
    salt = bcrypt.gensalt()
    pwd = password.encode()
    hashed = bcrypt.hashpw(pwd, salt)
    hashed = hashed.decode('utf-8')
    print(hashed)
    return render(request,'contact-us.html')


def thanks(request):
    return render(request, 'thanks.html')

class ContactUs(TemplateView):
    template_name = 'contact-us.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context


class Features(TemplateView):
    template_name = 'features.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context

class Index(TemplateView):
    template_name = 'index.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context

class Meetings(TemplateView):
    template_name = 'meetings.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context




class Teams(TemplateView):
    template_name = 'team.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context

class Tutorials(TemplateView):
    template_name = 'tutorials.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context

class Register(TemplateView):
    template_name = "register.html"

    def post(self,request):
        try :
            email = request.POST.get('email')
            fname = request.POST.get('fname')
            lname = request.POST.get('lname')
            password = request.POST.get('password')
            check_user = Users.objects.filter(email=email)
            if not check_user:
                salt = bcrypt.gensalt()
                pwd = password.encode()
                hashed = bcrypt.hashpw(pwd, salt)
                hashed = hashed.decode('utf-8')
                username = fname +" "+ lname
                uuid ="gl-" + ''.join(random.choices(string.ascii_lowercase, k = 12))
                name = username
                res = ''.join(random.choices(string.ascii_lowercase +string.digits, k = 6))
                ruid = name[:3].lower() + "-" + res[:3] + "-" + res[3:]
                bbb_id = ''.join(random.choices(string.ascii_lowercase +string.digits, k = 40))
                room_settings = {}
                moderator_pw = ''.join(random.choices(string.ascii_lowercase +string.ascii_uppercase, k = 12))
                attendee_pw = ''.join(random.choices(string.ascii_lowercase +string.ascii_uppercase, k = 12))
                deleted = False
                user = Users.objects.create_user(provider="Wofemtech", name=username, email=email, password=hashed, language="default", role_id=1, deleted=False, uid=uuid)
                new_room = Rooms.objects.create(user_id=user.id, name="Home Room", uid=ruid, bbb_id=bbb_id, sessions=0, room_settings={}, moderator_pw=moderator_pw, attendee_pw=attendee_pw, deleted=False)
                Users.objects.filter(id=user.id).update(room_id=new_room.id)
                login(request,user)
                return redirect("wofemtech:index")
            else:
                return render(requet,"register.html")
        except:
            messages.add_message(request, messages.ERROR, "Something went wrong..!!")
            return render(request,'register.html')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context
        

class LogIn(TemplateView):
    template_name = "login.html"

    def post(self, request):
        email = request.POST.get('username')
        password = request.POST.get('password')
        print(email)
        print(password)
        context = {}
        try:
            user = Users.objects.get(email=email)
            if user:
                pwd = bcrypt.checkpw(password.encode(), user.password.encode())
                if pwd == True:
                    login(request,user)
                    return redirect("wofemtech:index")
                else:
                    context['msg'] = "Password not match..!!"
                    return render(request, "login.html", context=context)
            else:
                context['msg'] = "Email not found..!!"
                return render(request,"login.html",context=context)
        except:
            context['msg'] = "Username or password is incorrect..!!"
            return render(request,"login.html",context=context)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context

class LogOut(RedirectView):
    url = '/'

    def get(self, request, *args, **kwargs):
        logout(request)
        return super(LogOut, self).get(request, *args, **kwargs)

class pricing(TemplateView):
    template_name = 'pricing.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['products'] = Product.objects.all()
        descriptions = ProductDescription.objects.all()
        datas = {}
        for des in descriptions:
            datas[des.product] = des.description
        context['description'] = datas
        plan = Plan.objects.all()
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
        except:
            pass
        return context

# def pricing(request):
#     products = Product.objects.all()
#     descriptions = ProductDescription.objects.all()
#     data = {}
#     for des in descriptions:
#         data[des.product] = des.description
    
#     return render(request,"pricing.html",{"products":products,"description":data})

@login_required
def checkout(request):
    products = Product.objects.all()
    return render(request,"checkout.html",{"products": products})


@login_required
def create_sub(request):
    if request.method == 'POST':
        # Reads application/json and returns a response
        data = json.loads(request.body)
        payment_method = data['payment_method']
        stripe.api_key = settings.STRIPE_TEST_SECRET_KEY

        payment_method_obj = stripe.PaymentMethod.retrieve(payment_method)
        djstripe.models.PaymentMethod.sync_from_stripe_data(payment_method_obj)


        try:
            # This creates a new Customer and attaches the PaymentMethod in one API call.
            customer = stripe.Customer.create(
                name=request.user.name,
                payment_method=payment_method,
                email=request.user.email,
                invoice_settings={
                    'default_payment_method': payment_method
                },
                address={
                    'line1': '510 Townsend St',
                    'postal_code': '98140',
                    'city': 'San Francisco',
                    'state': 'CA',
                    'country': 'US',
                  },
            )

            djstripe_customer = djstripe.models.Customer.sync_from_stripe_data(customer)
            request.user.customer = djstripe_customer
           

            # At this point, associate the ID of the Customer object with your
            # own internal representation of a customer, if you have one.
            # print(customer)

            # Subscribe the user to the subscription created
            subscription = stripe.Subscription.create(
                customer=customer.id,
                items=[
                    {
                        "price": data["price_id"],
                    },
                ],
                expand=["latest_invoice.payment_intent"]
            )

            djstripe_subscription = djstripe.models.Subscription.sync_from_stripe_data(subscription)

            request.user.subscription = djstripe_subscription
            request.user.save()
            print(subscription)
            if subscription.get("status") == "active":
                start = subscription.get("current_period_start")
                start_date = datetime.fromtimestamp(int(start))
                aware_start_date_db = timezone.make_aware(start_date, timezone.get_default_timezone())
                start_date = start_date.strftime('%b %d, %Y')
                expiry = subscription.get("current_period_end")
                expiry_date = datetime.fromtimestamp(int(expiry))
                expiry_date = expiry_date.strftime("%A, %b %d, %Y,"+" at "+" %H:%M:%S %Z")
                expiry_date_db = datetime.fromtimestamp(expiry)
                aware_expiry_date_db = timezone.make_aware(expiry_date_db, timezone.get_default_timezone())
                items = subscription.get("items")
                if items:
                    data = items.get("data")
                    if data:
                        print("data mali gayo che")
                        plan_id = data[0]["plan"]["id"]
                        product_id = data[0]["plan"]["product"]
                        plan_detail = Plan.objects.get(id=plan_id)
                        plan_amount = plan_detail.amount
                        plan_currency = plan_detail.currency
                        plan_duration = plan_detail.interval
                        product_detail = Product.objects.get(id=product_id)
                        product_name = product_detail.name
                        product_descriptions = ProductDescription.objects.get(product=product_id)
                        descriptions = product_descriptions.description
                        description_list = descriptions.split(",")

                        send_purchase_mail = after_subscription_send_mail(plan_name=product_name,email_data=request.user.email,duration=plan_duration,start_date=start_date,expiry_date=expiry_date,plan_amount=int(plan_amount),plan_features=description_list,plan_currency=plan_currency)
                        u_update = User_Subscribe_Mail.objects.create(user_id=request.user.id,Subscribed=True,start_date=aware_start_date_db,expiry_date=aware_expiry_date_db,product_id=product_id,plan_id=plan_id)
                        # U_update = User_Mail.objects.filter(user_id=request.user.id).update(Subscribed=True)
                        u_delete = User_Mail.objects.filter(user_id=request.user.id).delete()

            # print("*"*10)
            # print(subscription["status"])
            # print("*"*10)

            print("json response sent")
            return JsonResponse(subscription)
        except Exception as e:
            print("error")
            return JsonResponse({'error': (e.args[0])}, status =403)
    else:
        return HttpResponse('requet method not allowed')

def complete(request):
    return render(request, "complete.html")

class cart(APIView):

    def get(self,request):
        finaldata = []
        user_id = self.request.user.id
        plan_id = request.GET.get('plan_id')
        product_id = request.GET.get('product_id')
        print(plan_id,product_id,user_id)
        try:
            get_obj = Cart.objects.get(user_id=user_id)
            if get_obj:
                get_obj.product_id = product_id
                get_obj.plan_id = plan_id
                get_obj.save()
                msg = "Cart value updated"
        except:
            new_obj = Cart.objects.create(user_id=user_id,product_id=product_id,plan_id=plan_id)
            msg = "Cart object created"
        return Response({"status":True, "code":200,"msg":msg})

class ClearCart(APIView):

    def get(self,request):
        Cart.objects.filter(user_id=self.request.user.id).delete()
        msg = "Cart Product Removed."
        return Response({'status':True,"code":200,"msg":msg})


class StartPayment(TemplateView):
    template_name = "Payment1.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        plan = Plan.objects.all()
        # print(plan)
        context['pemail'] = self.request.user.email
        try:
            product = Cart.objects.get(user_id=self.request.user.id)
            
            data = Product.objects.filter(id=product.product_id)
            for d in data:
                context['pname'] = d.name
                context['pdescription'] = d.description
                for image in d.images:
                    context['pimage'] = image
            plandetails = Plan.objects.filter(id=product.plan_id)
            for p in plandetails:
                context['pamount'] = p.amount
                context['pinterval'] = p.interval
                context['pid'] = p.id
                print(p.id)
        except:
            pass
        return context

class Profile(TemplateView):
    template_name = 'profile.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        today = datetime.utcnow().replace(tzinfo=pytz.UTC)
        try:
            customer = Customer.objects.filter(email=self.request.user.email).order_by('-created')[0]
            print(customer)
            print(customer.id)
            print(customer.subscription.current_period_end)
            print(customer.subscription.current_period_start)
            print(customer.subscription.id)
            plan_id = customer.subscription.plan
            plan_name = Plan.objects.get(id=plan_id)
            print(plan_name,"plan")
            active_plan_name = plan_name.product
            active_plan_interval = plan_name.interval
            context['plan_name'] = active_plan_name 
            context['plan_interval']  = active_plan_interval
            context['plan_expiry'] = customer.subscription.current_period_end
            context['sub_id'] = customer.subscription.id
            context['remaining_plan_days'] = (customer.subscription.current_period_end-today).days
            # print(plan_name.plan.product)
            return context
        except:
            pass

class ForgetpasswordView(TemplateView):
    template_name = "forget_password.html"

    def post(self, request):
        email = request.POST.get('email')
        print(email)
        user = Users.objects.filter(email=email)
        print(user[0])
        if len(user) > 0:
            user[0].forgot_password = True
            user[0].save()
            current_site = get_current_site(request)
            # subject = 'Reset Password'
            # message = render_to_string('forget_password_email.html', {
            #     'user': user[0],
            #     'domain': current_site.domain,
            #     'uid': urlsafe_base64_encode(force_bytes(user[0].pk)),
            #     'token': account_activation_token.make_token(user[0]),
            # })
            # print(message)
            # send_mail(subject, message, settings.EMAIL_HOST_USER, [user[0].email])
            send_forgot_password_mail(username=user[0].name,domain=current_site.domain,uidb64=urlsafe_base64_encode(force_bytes(user[0].pk)),token=account_activation_token.make_token(user[0]),email_data=user[0].email)
        return redirect('wofemtech:forgotpassword')

class PasswordChangeView(View):

    def get(self, request, **kwargs):
        uid = force_text(urlsafe_base64_decode(kwargs['uidb64']))
        user = Users.objects.get(pk=uid)
        a = account_activation_token.check_token(user,kwargs['token'])
        try:
            uid = force_text(urlsafe_base64_decode(kwargs['uidb64']))
            user = Users.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, Users.DoesNotExist):
            user = None
        if user is not None and user.forgot_password == False:
            return redirect('wofemtech:index')
        return render(request, 'change_password.html', context={"valid":a})

    def post(self, request, uidb64, token, *args, **kwargs):
        password = request.POST.get('password')
        uid = force_text(urlsafe_base64_decode(uidb64))    
        user = Users.objects.get(pk=uid)
        user.forgot_password = False
        salt = bcrypt.gensalt()
        pwd = password.encode()
        hashed = bcrypt.hashpw(pwd, salt)
        pwd = hashed.decode('utf-8')
        user.password = pwd
        # user.set_password(hashed)
        user.save()
        return redirect('wofemtech:index')

class UpdatePass(APIView):
    def post(self, request):
        context = {}
        old_pass = request.POST.get('old_pass')
        new_pass = request.POST.get('new_pass')
        print(old_pass,new_pass)
        msg = "asdf"
        user = Users.objects.get(email=self.request.user.email)
        if user:
            pwd = bcrypt.checkpw(old_pass.encode(), user.password.encode())
            if pwd == True:
                print("password match")
                salt = bcrypt.gensalt()
                pwd = new_pass.encode()
                hashed = bcrypt.hashpw(pwd, salt)
                hashed = hashed.decode('utf-8')
                user.password = hashed
                user.save()
                messages.info(request,"Password Changed Succeessfully..")
                context['msg'] = "Password Changed Succeessfully.."
            else:
                context['msg'] = "Old Password Is Not Matching.."
                messages.info(request,"Old Password Is Not Match With Your Entered Password..")
                print("password not match")
        return Response({'status':True,"code":200,"context":context})

class UpdateProfile(APIView):
    def post(self, request):
        context = {}
        name = request.POST.get('name')
        email = request.POST.get('email')
        language = request.POST.get('language')
        user = Users.objects.get(email=self.request.user.email)
        if user:
            user.name = name
            user.email = email
            user.language = language
            user.save()
            messages.info(request,"Profile data updated...")
        else:
            messages.info(request,"Something went wrong ..")
        return Response({'status':True,"code":200,"context":context})

class cancel_subscription(APIView):
    def post(self,request):
        sub_id = request.POST.get('sub_id')
        if request.user.is_authenticated:
            # sub_id lavani ahiya
            stripe.api_key = settings.STRIPE_TEST_SECRET_KEY

            try:
                stripe.Subscription.delete(sub_id)
                # customer.subscription.delete
                messages.info(request,"Subscription Canceled Succeessfully..")
                print("Canceled")
                return Response({'status':True,'code':200,'msg':"Subscription Canceled Succeessfully.."})
            except Exception as e:
                messages.info(request,"Subscription already Canceled..!!")
                print("error")
                # return JsonResponse({'error': (e.args[0])}, status =403)
                return Response({'status':True,'msg':"Subscription already Canceled..!!",'code':201,'error': (e.args[0])})
            # messages.info(request,"Subscription Canceled Succeessfully..")
        # return Response({'status':True,'code':200,})
        # return redirect("wofemtech:profile")

class Demo(TemplateView):
    template_name = "demo.html"

class DemoMail(APIView):

    def post(self,request):
        name = request.POST.get('name')
        email = request.POST.get('email')
        phone_number = request.POST.get('phone_number')
        country = request.POST.get('country')
        company_name = request.POST.get('company')
        employee = request.POST.get('emp_count')
        pre_date = request.POST.get('date')
        pre_time = request.POST.get('time')
        information = request.POST.get('message')
        email_data = "thakkarmeet88@gmail.com"
        try:
            request_demo_mail(name=name,email=email,phone_number=phone_number,country=country,company_name=company_name,total_emp=employee,pdate=pre_date,ptime=pre_time,demo_message=information,email_data=email_data)
            return Response({'status':True,'code':200,'msg':'Demo Request Send Succeessfully..!!'})
        except:
            return Response({'status':True,'code':201,'msg':"Something went wrong..!!"})

class DemoSuccess(TemplateView):
    template_name = 'demo_success.html'

class SendContactUsMail(APIView):

    def post(self, request):
        name = request.POST.get('name')
        email = request.POST.get('email')
        phone_number = request.POST.get('phone_number')
        company_name = request.POST.get('company')
        priority = request.POST.get('priority')
        address = request.POST.get('address')
        issue = request.POST.get('issue')
        message = request.POST.get('message')
        email_data = "thakkarmeet88@gmail.com"
        print(name,email,phone_number,company_name,priority,address,issue,message)
        try:

            contact_us_mail(email_data=email_data,name=name,email=email,phone_number=phone_number,priority=priority,company=company_name,address=address,issue=issue,contact_message=message)
            return Response({"status": True, "code": 200, "msg": "ContactUs details saved Succeessfully..!!"})
        except:
            return Response({"status":True, "code":200, "msg":"Something went wrong..!!"})

class UserDataForm(APIView):

    def post(self, request):
        email = request.POST.get('email')
        fname = request.POST.get('fname')
        lname = request.POST.get('lname')
        address1 = request.POST.get('address1')
        address2 = request.POST.get('address2')
        city = request.POST.get('city')
        territory = request.POST.get('territory')
        postal_code = request.POST.get('postal_code')
        country = request.POST.get('country')
        phone_number = request.POST.get('phone_number')
        phone_code = request.POST.get('phone_code')
        try:
            User_Details.objects.create(email_id=email,first_name=fname,last_name=lname,address1=address1,address2=address2,city=city,territory=territory,postal_code=postal_code,
                country=country,phone_number=phone_number,phone_code=phone_code)
            return Response({'status':True,'code':200})
        except:
            return Response({'status':True,'code':201})


def SendSubscribeMail(email):
    data = {
        "email_address":email,
        "status":"subscribed"
    }

    r = requests.post(
        members_endpoint,
        auth=("",MAILCHIMP_API_KEY),
        data=json.dumps(data)
    )
    return r.status_code, r.json()

def subscribe(request):
    if request.method == 'POST':
        email = request.POST['email']
        # print(email)
        email_qs = Subscribe.objects.filter(email_id = email)
        if email_qs.exists():
            # return HttpResponse('You are already subscribed')
            messages.info(request,"You are already subscribed")
        else:
            Subscribe.objects.create(email_id = email)
            SendSubscribeMail(email) # Send the Mail, Class available in utils.py
            
    return HttpResponseRedirect(request.META.get("HTTP_REFERER"))



