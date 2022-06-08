# flask-airflow-onboarding

Flask app to deploy ldap.yaml and airflow_pool.yaml changes

# Main page

![Screenshot](images/landing_page.png)

# How this work? (this is just an idea yet)

1. User adds input `appcode (i.e, ABC0)` through webpage
2. App pulls `ldap git repo` and creates a new branch (i.e. onboarding-ABC0)
3. `echo APP_MUV0_ABC0_USER >> ldap.yaml` and pushes the change into repo
4. App pulls `pool git repo` and creates a new branch (i.e. onboarding-ABC0)
5. `echo ABC0_pool=10 >> ldap.yaml` and pushes the change into repo (10 slots by default)
6. Jenkins pipeline will trigger new build -> deploy into Openshift

