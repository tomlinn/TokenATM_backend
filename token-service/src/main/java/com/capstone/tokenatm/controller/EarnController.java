package com.capstone.tokenatm.controller;

import com.capstone.tokenatm.entity.TokenCountEntity;
import com.capstone.tokenatm.exceptions.BadRequestException;
import com.capstone.tokenatm.exceptions.InternalServerException;
import com.capstone.tokenatm.service.Beans.AssignmentStatus;
import com.capstone.tokenatm.service.Request.RequestUserIdBody;
import com.capstone.tokenatm.service.Request.UseTokenBody;
import com.capstone.tokenatm.service.EarnService;
import com.capstone.tokenatm.service.Response.RequestUserIdResponse;
import com.capstone.tokenatm.service.Response.UpdateTokenResponse;
import com.capstone.tokenatm.service.Response.UseTokenResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.*;

@RestController
public class EarnController {

    private static final Logger LOGGER = LoggerFactory.getLogger(EarnService.class);

    @Autowired
    EarnService earnService;

    @GetMapping(path="/assignment_status/{user_id}")
    public @ResponseBody List<AssignmentStatus> getAssignmentStatuses(@PathVariable String user_id) throws JSONException, IOException {
        return earnService.getAssignmentStatuses(user_id);
    }

    @GetMapping(path="/sync")
    public @ResponseBody Iterable<TokenCountEntity> manualSync() throws JSONException, IOException {
        return earnService.manualSyncTokens();
    }

    @GetMapping(path="/tokens/{user_id}")
    public @ResponseBody Optional<TokenCountEntity> getTokenForStudent(@PathVariable String user_id) {
        return earnService.getStudentTokenCount(user_id);
    }

    //For testing if Qualtrics is working
    @GetMapping("/whoami")
    public String whoami(
    ) throws InternalServerException {
        try {
            return earnService.getIdentity();
        } catch (JSONException | IOException e) {
            LOGGER.error(e.toString());
            throw new InternalServerException();
        }
    }

    @GetMapping("/survey_export")
    public Set<String> getSurveyExport(
    ) throws InternalServerException {
        return earnService.getSurveyCompletions("SV_8oIf0qAz5g0TFiK");
    }

    @GetMapping("/grades")
    public HashMap<Object, Object> getStudentsData(
    )  throws InternalServerException {
        try {
            return earnService.getStudentGrades();
        } catch (IOException | JSONException e) {
            e.printStackTrace();
            throw new InternalServerException();
        }
    }

    @GetMapping("/students")
    public Iterable<TokenCountEntity> getStudents(
    ) {
        return earnService.getAllStudentTokenCounts();
    }

    @GetMapping("/token_grades")
    public Map<String, Double> getTokenGrades(
    ) throws InternalServerException {
        try {
            return earnService.getStudentTokenGrades();
        } catch (IOException | JSONException e) {
            e.printStackTrace();
            throw new InternalServerException();
        }
    }

    @GetMapping("/courses")
    public Map<String, Object> getCourseData(
    ) throws InternalServerException {
        try {
            return earnService.getCourseData();
        } catch (IOException | JSONException e) {
            e.printStackTrace();
            throw new InternalServerException();
        }
    }

    /**
     * Body: {
     *     "assignment_id": string,
     *     "cost": int
     * }
     */
    @PostMapping(path="/use_token/{user_id}")
    public @ResponseBody UseTokenResponse useToken(@PathVariable String user_id, @RequestBody UseTokenBody body) throws IOException, BadRequestException, JSONException {
        return earnService.useToken(user_id, body.getAssignment_id(), body.getToken_count());
    }

    @PostMapping("/update")
    public @ResponseBody UpdateTokenResponse updateToken(@RequestParam String studentId, @RequestParam Integer tokenNum) throws JSONException, IOException {
        return earnService.updateToken(studentId, tokenNum);
    }

    @PostMapping("/userid")
    public @ResponseBody RequestUserIdResponse getUserId(@RequestBody RequestUserIdBody body) throws JSONException, IOException {
        return earnService.getUserIdFromEmail(body.getEmail());
    }
}