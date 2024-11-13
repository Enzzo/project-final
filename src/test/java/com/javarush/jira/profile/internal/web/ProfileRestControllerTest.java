package com.javarush.jira.profile.internal.web;

import com.javarush.jira.login.AuthUser;
import com.javarush.jira.profile.ProfileTo;
import com.javarush.jira.profile.internal.web.ProfileRestController;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.Collections;

import static org.mockito.Mockito.*;
import static org.mockito.MockitoAnnotations.openMocks;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

class ProfileRestControllerTest {

    private MockMvc mockMvc;

    @Mock
    private AuthUser authUserMock;

    @InjectMocks
    private ProfileRestController profileRestController;

    @BeforeEach
    void setUp() {
        openMocks(this); // Инициализируем Mockito
        mockMvc = MockMvcBuilders.standaloneSetup(profileRestController).build();
    }

    @Test
    void testGetProfileSuccess() throws Exception {
        // Создаем фиктивный объект ProfileTo
        ProfileTo profileTo = new ProfileTo(1L, Collections.singleton("email_notification"), Collections.emptySet());

        // Мокаем поведение метода get() в контроллере
        when(authUserMock.id()).thenReturn(1L);
        when(profileRestController.get(authUserMock)).thenReturn(profileTo);

        // Выполняем GET-запрос и проверяем ответ
        mockMvc.perform(get(ProfileRestController.REST_URL)
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
                .andExpect(jsonPath("$.id").value(1L))
                .andExpect(jsonPath("$.mailNotifications[0]").value("email_notification"));
    }

    @Test
    void testGetProfileUnauthorized() throws Exception {
        // Проверка на случай, если пользователь не авторизован
        when(authUserMock.id()).thenReturn(1L);
        when(profileRestController.get(authUserMock)).thenReturn(null);

        mockMvc.perform(get(ProfileRestController.REST_URL)
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isUnauthorized()); // Ожидаем статус 401 Unauthorized
    }

    @Test
    void testUpdateProfileSuccess() throws Exception {
        // Создаем фиктивный объект ProfileTo для успешного обновления
        ProfileTo profileTo = new ProfileTo(1L, Collections.singleton("email_notification"), Collections.emptySet());

        when(authUserMock.id()).thenReturn(1L);
        mockMvc.perform(put(ProfileRestController.REST_URL)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"id\": 1, \"mailNotifications\": [\"email_notification\"], \"contacts\": []}"))
                .andExpect(status().isNoContent());
        verify(profileRestController, times(1)).update(profileTo, 1L);
    }

    @Test
    void testUpdateProfileValidationError() throws Exception {
        String invalidJson = "{\"id\": 1, \"mailNotifications\": [], \"contacts\": []}";

        mockMvc.perform(put(ProfileRestController.REST_URL)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(invalidJson))
                .andExpect(status().isBadRequest()); // Ошибка валидации (400)
    }

    @Test
    void testUpdateProfileUnauthorized() throws Exception {
        // Здесь мы тестируем ошибку авторизации. Например, если профиль не может быть обновлен из-за проблем с правами доступа
        // Мы не вызываем сам метод update, а проверяем статус Unauthorized (401).
        when(authUserMock.id()).thenReturn(1L);

        mockMvc.perform(put(ProfileRestController.REST_URL)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"id\": 1, \"mailNotifications\": [\"email_notification\"], \"contacts\": []}"))
                .andExpect(status().isUnauthorized()); // Ожидаем статус 401 Unauthorized
    }
}
