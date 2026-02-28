from locust import HttpUser, task, between

class WebServerLoadTest(HttpUser):
    # Simulates a user waiting 1-2 seconds between requests
    wait_time = between(1, 2)

    @task(3)
    def get_index(self):
        self.client.get("/loadTest/index.html", verify=False)

    @task(2)
    def get_app_js(self):
        self.client.get("/loadTest/app.js", verify=False)

    @task(1)
    def get_hero_image(self):
        # Testing the throughput on the 10MB file
        self.client.get("/loadTest/hero.jpg", verify=False)

