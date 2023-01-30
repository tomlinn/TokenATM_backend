package com.capstone.tokenatm.service.impl;

import java.util.Optional;

import com.capstone.tokenatm.entity.ConfigEntity;
import com.capstone.tokenatm.service.ConfigRepository;
import com.capstone.tokenatm.service.ConfigService;
import com.capstone.tokenatm.service.Response.UpdateConfigResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("ConfigService")
public class ConfigServiceImpl implements ConfigService {
    @Autowired
    private ConfigRepository ConfigRepository;

    public UpdateConfigResponse updateConfigEntity(Integer id, String config_name) {
        Optional<ConfigEntity> optional = ConfigRepository.findById(id);
        ConfigEntity entity = null;
        if (optional.isPresent()) {
            entity = optional.get();
            entity.setConfigName(config_name);
        }
        ConfigRepository.save(entity);
        return null;
    }
}