CREATE KEYSPACE IF NOT EXISTS buckets_proxy_tiering WITH REPLICATION = { 'class' : 'NetworkTopologyStrategy', 'replication_factor' : 1 };

USE buckets_proxy_tiering;

CREATE TABLE objects (
     bucket text,
     key text,
     storageclass text,
     location text,
     locked boolean,
     primary key (bucket, key)
);

CREATE TABLE restores(
     bucket text,
     key text,
     restore_bucket text,
     restore_key text,
     location text,
     queued_at timestamp,
     worker uuid,
     started_at timestamp,
     completed_at timestamp,
     primary key ((bucket, key), restore_bucket, restore_key, location)
);

CREATE TABLE archives (
      bucket text,
      key text,
      location text,
      created_at timestamp,
      done boolean,
      completed_at timestamp,
      primary key (bucket, key, location)
);

CREATE TABLE multipartUploads (
      bucket text,
      uploadid text,
      storageclass text,
      locked boolean,
      primary key (bucket, uploadid)
);

CREATE TABLE deletes (
     location text,
     created_at timestamp,
     done boolean,
     completed_at timestamp,
     primary key (location)
);