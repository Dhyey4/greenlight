from django.core.management.base import BaseCommand, CommandError
from datetime import datetime, timedelta
import pytz
import requests
from wofemtech.models import *
from wofemtech.views import *
import os
from django.db.models import Q, F
from django.utils import timezone

import warnings
warnings.filterwarnings('ignore')

current_time = datetime.now()
last_hour_date_time = datetime.now() - timedelta(hours = 1)
aware_current_time = timezone.make_aware(datetime.now(), timezone.get_default_timezone())

class Command(BaseCommand):
	help = 'for mail send'

	def handle(self, *args, **options):
		users = Users.objects.filter(created_at__gte=last_hour_date_time)
		if users:
			for user in users:
				p,new_entry = User_Mail.objects.get_or_create(user_id=user.id)
    			
				if new_entry == True:
					sending_welcome_mail = welcome_mail(email_data=user.email)
					User_Mail.objects.filter(user_id=user.id).update(welcome_mail=True)
		else:
			print("NEW USERS NOT FOUND")

		three_day_filter =  User_Mail.objects.filter(welcome_mail=True,Subscribed=False,day3_mail=False,day9_mail=False,day13_mail=False)
		if three_day_filter:
			for data in three_day_filter:
				after_three_day_date = data.created_at + timedelta(days=3)
				if aware_current_time >=  after_three_day_date:
					email_user = Users.objects.get(id=data.user_id)
					sending_3days_mail = after_3days_send_mail(email_data=email_user.email)
					User_Mail.objects.filter(user_id=data.user_id).update(day3_mail=True)
				else:
					print("DATE CONDITIONS NOT MATCHING")
		else:
			print("NO USER FOUND WITH 3 DAYS MARGIN")

		nine_day_filter = User_Mail.objects.filter(welcome_mail=True,day3_mail=True,day9_mail=False,day13_mail=False,Subscribed=False)
		if nine_day_filter:
			for data in nine_day_filter:
				after_nine_day_date = data.created_at + timedelta(days=9)
				if aware_current_time >= after_nine_day_date:
					email_user = Users.objects.get(id=data.user_id)
					sending_9days_mail = after_9days_send_mail(email_data=email_user.email)
					User_Mail.objects.filter(user_id=data.user_id).update(day9_mail=True)
				else:
					print("DATE CONDITIONS NOT MATCHING")
		else:
			print("NO USER FOUND WITH 9 DAYS MARGIN")

		thirteen_day_filter = User_Mail.objects.filter(welcome_mail=True,day3_mail=True,day9_mail=True,day13_mail=False,Subscribed=False)
		if thirteen_day_filter:
			for data in thirteen_day_filter:
				after_thirteen_day_date = data.created_at + timedelta(days=13)
				if aware_current_time >= after_thirteen_day_date:
					email_user = Users.objects.get(id=data.user_id)
					sending_13days_mail = after_13days_send_mail(email_data=email_user.email)
					User_Mail.objects.filter(user_id=data.user_id).update(day13_mail=True)
				else:
					print("DATE CONDITIONS NOT MATCHING")
		else:
			print("NO USER FOUND WITH 13 DAYS MARGIN")

		fourteen_day_filter = User_Mail.objects.filter(welcome_mail=True,day3_mail=True,day9_mail=True,day13_mail=True,Subscribed=False)
		if fourteen_day_filter:
			for data in fourteen_day_filter:
				after_fourteen_day_date = data.created_at + timedelta(days=14)
				date_obj = after_fourteen_day_date.strftime("%A, %b %d, %Y,"+" at "+" %H:%M:%S %Z")
				if aware_current_time >=after_fourteen_day_date:
					email_user = Users.objects.get(id=data.user_id)
					sending_free_expired_mail = free_expired_send_mail(email_data=email_user.email,date_time=date_obj)
					User_Mail.objects.filter(user_id=data.user_id).delete()
				else:
					print("DATE CONDITIONS NOT MATCHING")
		else:
			print("NO USER FOUND WITH 14 DAYS MARGIN")

		threedays_before_expired_plan = User_Subscribe_Mail.objects.filter(oneweek_ago=False)
		if threedays_before_expired_plan:
			for data in threedays_before_expired_plan:
				three_day_before_date = data.expiry_date - timedelta(days=3)
				print(three_day_before_date)
				if aware_current_time >= three_day_before_date:
					email_user = Users.objects.get(id=data.user_id)
					sending_mail_before_plan_expired = send_mail_before_subscription_expired(email_data=email_user.email)
					User_Subscribe_Mail.objects.filter(user_id=data.user_id).update(oneweek_ago=True)
				else:
					print("DATE CONDITIONS NOT MATCHING")
		else:
			print("NO USER FOUND WITH 3 DAYS PLAN EXPIRED MARGIN")

		plan_expired = User_Subscribe_Mail.objects.filter(oneweek_ago=True,expired=False)
		if plan_expired:
			for data in plan_expired:
				plan_expiry_date = data.expiry_date
				plan_id = data.plan_id
				product_id = data.product_id
				start_date = data.start_date
				start_date = start_date.strftime('%b %d, %Y')
				expiry_date = data.expiry_date
				expiry_date = expiry_date.strftime('%b %d, %Y')
				if aware_current_time >= plan_expiry_date:
					email_user = Users.objects.get(id=data.user_id)
					plan_detail = Plan.objects.get(id=plan_id)
					plan_amount = plan_detail.amount
					plan_currency = plan_detail.currency
					plan_duration = plan_detail.interval
					product_detail = Product.objects.get(id=product_id)
					product_name = product_detail.name
					product_descriptions = ProductDescription.objects.get(product=product_id)
					descriptions = product_descriptions.description
					description_list = descriptions.split(",")

					send_plan_expired_mail = send_mail_plan_expired(plan_name=product_name,email_data=email_user.email,duration=plan_duration,start_date=start_date,expiry_date=expiry_date,plan_amount=int(plan_amount),plan_features=description_list,plan_currency=plan_currency)
					User_Subscribe_Mail.objects.filter(user_id=data.user_id).delete()
				else:
					print("DATE CONDITIONS NOT MATCHING")
		else:
			print("NO USER FOUND WITH PLAN EXPIRED MARGIN")

