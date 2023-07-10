from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello, world. You're at the avicenna index.")

def delete_user(request, user_id):
    return HttpResponse("You've deleted user #%s." % user_id)


def create_user(request, user_id):
    response = "You've created user #%s."
    return HttpResponse(response % user_id)


def update_user(request, user_id):
    return HttpResponse("You've updated user #%s." % user_id)

def register_user(request, user_id):
    return HttpResponse("You've registered user #%s." % user_id)

def log_in_user(request, user_id):
    return HttpResponse("You've logged in as user #%s." % user_id)