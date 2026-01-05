### Create the script named script.sh for User data

Make 3 ec2 instance using the script which bootstrap Docker installation before startup :

```
#!/bin/bash


# 1. Update the local package database

sudo apt update -y


# 2. Install the Docker engine via the official Ubuntu repositories (apt only)

# 'docker.io' is the standard Ubuntu-maintained package

sudo apt install -y docker.io



# 3. Ensure Docker starts automatically on boot

sudo systemctl enable --now docker



# 4. Give the 'ubuntu' user permission to run Docker without sudo

# This avoids "permission denied" errors when you log in later

sudo usermod -aG docker ubuntu
```







### After creating 3 ec2, rename the hostname :-
```
sudo hostnamectl set-hostname ds-master
sudo hostnamectl set-hostname ds-w1
sudo hostnamectl set-hostname ds-w2
```



### Run the below command in Master : 
```
docker swarm init --advertise-addr 13.13.13.13
```


### Paste the output command from Master in the 2 worker : 
```
docker swarm join --token SWMTKN-1-1ctuqs6jdk7to42albh25evjxggot3hpk5s90kqxb4xdln4ro5-9iy2cd9nkguo0kwu4xstmeqyx 13.13.13.13:2377
```

### Allow 2377 port in master from the security group (CIDR x.x.x.x/32) 

### Now from Master, run the below command : 

```docker node ls```

### For Visualize :-
```
docker service create \
  --name=viz \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer
```


### Provide the load to the cluster :- 
```
docker service create \
  --name nginx-service \
  --publish published=80,target=80 \
  --replicas 3 \
  nginx:latest
```

### Check cluster :-
```
docker service ls
```




### Scale services dynamically:-
```
sudo docker service scale nginx-service=5
```
