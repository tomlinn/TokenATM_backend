package com.capstone.tokenatm.service;

import java.io.IOException;
import java.util.List;

import com.capstone.tokenatm.entity.ConfigEntity;
import com.capstone.tokenatm.service.Response.UpdateConfigResponse;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called LogRepository
// CRUD refers Create, Read, Update, Delete

public interface ConfigRepository extends CrudRepository<ConfigEntity, Integer> {

    @Query("SELECT l.config_name from ConfigEntity l WHERE l.config_type = ?1")
    List<String> findByType(String config_type);
}
