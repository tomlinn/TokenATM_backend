package com.capstone.tokenatm.service;

import java.util.List;

import com.capstone.tokenatm.entity.SpendLogEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called LogRepository
// CRUD refers Create, Read, Update, Delete

public interface LogRepository extends CrudRepository<SpendLogEntity, Integer> {

    @Query("SELECT l from SpendLogEntity l WHERE l.user_id = ?1")
    Iterable<SpendLogEntity> findByUserId(String user_id);

    @Query("SELECT l from SpendLogEntity l WHERE l.user_id = ?1 and l.source = ?2 and l.type = ?3")
    List<SpendLogEntity> findByUserIdAssignmentIdType(String user_id, String assignment_id, String type);

    @Query("SELECT l from SpendLogEntity l WHERE l.user_id = ?1 and l.source = ?2")
    List<SpendLogEntity> findByUserIdAssignmentId(String user_id, String assignment_id);

    @Query("SELECT l from SpendLogEntity l WHERE l.user_name = ?1")
    Iterable<SpendLogEntity> findByUserName(String user_name);
}
