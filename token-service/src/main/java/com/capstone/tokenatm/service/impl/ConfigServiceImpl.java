package com.capstone.tokenatm.service.impl;

import java.io.IOException;
import java.util.Date;
import java.util.Optional;

import com.capstone.tokenatm.entity.ConfigEntity;
import com.capstone.tokenatm.service.ConfigRepository;
import com.capstone.tokenatm.service.ConfigService;
import com.capstone.tokenatm.service.Response.UpdateConfigResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONException;
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
            entity.setTimestamp(new Date());
        }
        ConfigRepository.save(entity);
        return new UpdateConfigResponse( "Config entity updated successfully");
    }

    @Override
    public UpdateConfigResponse addConfigEntity(String config_type, String config_name) throws JSONException, IOException {
        ConfigEntity entity = new ConfigEntity();
        entity.setConfigType(config_type);
        entity.setConfigName(config_name);
        entity.setTimestamp(new Date());
        ConfigRepository.save(entity);
        return new UpdateConfigResponse( "Config entity added successfully");
    }

    @Override
    public UpdateConfigResponse deleteConfigEntity(Integer id) throws JSONException, IOException {
        Optional<ConfigEntity> optional = ConfigRepository.findById(id);
        if (!optional.isPresent()) {
            return new UpdateConfigResponse( "Config entity not found");
        }
        ConfigRepository.delete(optional.get());
        return new UpdateConfigResponse("Config entity deleted successfully");
    }
}