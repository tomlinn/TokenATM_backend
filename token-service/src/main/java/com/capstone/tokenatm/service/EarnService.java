package com.capstone.tokenatm.service;

import com.capstone.tokenatm.entity.RequestEntity;
import com.capstone.tokenatm.entity.TokenCountEntity;
import com.capstone.tokenatm.exceptions.BadRequestException;
import com.capstone.tokenatm.exceptions.InternalServerException;
import com.capstone.tokenatm.service.Beans.AssignmentStatus;
import com.capstone.tokenatm.service.Response.CancelTokenResponse;
import com.capstone.tokenatm.service.Response.RejectTokenResponse;
import com.capstone.tokenatm.service.Response.RequestUserIdResponse;
import com.capstone.tokenatm.service.Response.UpdateTokenResponse;
import com.capstone.tokenatm.service.Response.UseTokenResponse;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;

import java.io.IOException;
import java.util.*;

public interface EarnService {

    HashMap<Object, Object> getStudentGrades() throws IOException, JSONException;

    Map<String, Object> getCourseData() throws IOException, JSONException;

    Map<String, Double> getStudentTokenGrades() throws IOException, JSONException;

    Iterable<TokenCountEntity> getAllStudentTokenCounts();

    Optional<TokenCountEntity> getStudentTokenCount(String user_id);

    void syncTokensOnDeadline() throws JSONException, IOException;

    Iterable<TokenCountEntity> manualSyncTokens() throws JSONException, IOException;

    UseTokenResponse useToken(String user_id, String assignment_id, Integer cost) throws IOException, BadRequestException, JSONException;

    UseTokenResponse useToken(RequestEntity request) throws IOException, BadRequestException, JSONException;

    CancelTokenResponse cancelToken(String user_id, String assignment_id, Integer cost) throws IOException, BadRequestException, JSONException;

    List<AssignmentStatus> getAssignmentStatuses(String user_id) throws JSONException, IOException;

    UpdateTokenResponse updateToken(String user_id, Integer tokenNum) throws JSONException, IOException;

    RequestUserIdResponse getUserIdFromEmail(String email) throws JSONException, IOException;

    RejectTokenResponse reject_token_use(RequestEntity request) throws JSONException, IOException;
}

