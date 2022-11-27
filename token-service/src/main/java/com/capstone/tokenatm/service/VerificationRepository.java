package com.capstone.tokenatm.service;

import com.capstone.tokenatm.entity.VerficationEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface VerificationRepository extends CrudRepository<VerficationEntity, String> {

    @Query("SELECT l from VerficationEntity l WHERE l.email = ?1")
    Optional<VerficationEntity> findByEmail(String email);
}
