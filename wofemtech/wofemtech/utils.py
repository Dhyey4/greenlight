import threading
# import mailchimp
from mailchimp3 import MailChimp
from django.conf import settings

class SendSubscribeMail(object):
	def __init__(self, email):
		self.email = email
		thread = threading.Thread(target=self.run, args=())
		thread.daemon = True                     
		thread.start()                                 

	def run(self):
		API_KEY = settings.MAILCHIMP_API_KEY
		LIST_ID = settings.MAILCHIMP_SUBSCRIBE_LIST_ID
		api = MailChimp(API_KEY)
		try:
			api.lists.members.create(LIST_ID, {'email': self.email, 'status':'subscribed'})
		except:
			return False
 

#  from mailchimp3 import MailChimp
# client = MailChimp('my_user', '{}-{}'.format(access_token, data_center))
# client.lists.members.create('my_list_id', {'email_address': 'test@gmail.com', 'status': 'subscribed'})