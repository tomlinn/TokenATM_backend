package com.capstone.tokenatm.service;

import java.io.IOException;

import com.capstone.tokenatm.service.Response.UpdateConfigResponse;
import org.springframework.boot.configurationprocessor.json.JSONException;

public interface ConfigService {
    UpdateConfigResponse updateConfigEntity(Integer id, String config_name) throws JSONException, IOException;
}

