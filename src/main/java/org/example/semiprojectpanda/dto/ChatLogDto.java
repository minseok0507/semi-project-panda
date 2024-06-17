package org.example.semiprojectpanda.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Builder
@AllArgsConstructor
public class ChatLogDto {
    private int chatnum;
    private int usernum;
    private String usernickname;
    private String userprofileimage;
    private int productnum;
    private String chatcontent;
}