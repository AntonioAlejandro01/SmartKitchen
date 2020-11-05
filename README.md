# SmartKitchen
Execute installation.sh or installation for windows
#### Download docker-compose.yml for microservices
```bash
curl https://raw.githubusercontent.com/AntonioAlejandro01/SmartKitchen/master/docker-compose.yml -o ./docker-compose.yml
```
#### Run microservices
```bash
docker-compose up -d
```
#### Run Frontend
```bash
docker run -p"80:80" -t antonioalejandro01/smktf-kitchen:1
```
<b>Docker and docker-compose is neccesary</b>

## Microservices
- [SMKT_Eureka](https://github.com/AntonioAlejandro01/SMKT_Eureka)
- [SMKT_Gateway](https://github.com/AntonioAlejandro01/SMKT_Gateway)
- [SMKT_Oauth](https://github.com/AntonioAlejandro01/SMKT_Oauth)
- [SMKT_Files](https://github.com/AntonioAlejandro01/SMKT_Files)
- [SMKT_Kitchen](https://github.com/AntonioAlejandro01/SMKT_Kitchen)
- [SMKT_Users](https://github.com/AntonioAlejandro01/SMKT_Users)
## Frontend
- [SMKTF_Kitchen](https://github.com/AntonioAlejandro01/SMKTF_Kitchen)
