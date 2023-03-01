package com.capstone.tokenatm.service;

import com.capstone.tokenatm.entity.RequestEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface RequestRepository extends CrudRepository<RequestEntity, Integer> {
        List<RequestEntity> findAllByOrderByIdDescStatusAsc();
        List<RequestEntity> findByStudentIdAndAssignmentIdOrderByIdDesc(String user_id, String assignment);
    }
