# What is Kibana?

Explore and Visualize Your Data

Kibana is an open source data visualization platform that allows you to interact with your data through stunning, powerful graphics that can be combined into custom dashboards that help you share insights from your data far and wide.

Kibana is a product of [Elastic.co](https://www.elastic.co/products/kibana).

This image is based on [Alpine](https://github.com/ukhomeoffice/docker-alpine/tree/latest) and the image size is approximately 57 MB .

You may used this image with [Elasticsearch] (https://github.com/ukhomeoffice/docker-alpine-elastic/tree/latest)

# Usage

Assuming you have a local runng:

```
docker run -d -name elasticsearch -p 9200:9200 -p 9300:9300 ukhomeoffice/elastic elasticsearch -Des.cluster.name="Kibana"
```

you can run the default `kibana` command simply:

```
docker run -d --name kibana -p 5601:5601 ukhomeoffice/kibana
```

or set the elasticsearch url :  


```
docker run -d --name kibana -p 5601:5601 ukhomeoffice/kibana kibana -e http://some-elasticsearch:9200
```

Alternatively, you can link Elasticsearch to the Kibana container :

```
docker run -d --name kibana --link elasticsearch:elasticsearch ukhomeoffice/kibana kibana -e http://elasticsearch:9200
```

This image comes with the default `kibana.yml` configuration file, but if you want to provide your own configuration file, you can do so via a volume mounted at `/usr/share/kibana/config`:

```
docker run -d -v "$PWD/config":/usr/share/kibana/config --link elasticsearch:elasticsearch ukhomeoffice/kibana kibana -e http://elasticsearch:9200
```

