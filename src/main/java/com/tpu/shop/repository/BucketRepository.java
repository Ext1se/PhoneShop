package com.tpu.shop.repository;

import com.tpu.shop.data.Bucket;
import com.tpu.shop.data.BucketId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BucketRepository extends JpaRepository<Bucket, BucketId> {

}
