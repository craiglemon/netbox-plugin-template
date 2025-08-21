from django.http import HttpResponse
from django.urls import path

def dummy_view(request):
    html = "<html><body>NetBox Sample plugin.</body></html>"
    return HttpResponse(html)

urlpatterns = [
    path("", dummy_view, name="myplugin_list"),
]