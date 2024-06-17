package org.example.semiprojectpanda.mapperInter;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.semiprojectpanda.dto.UserDto;

@Mapper
public interface UserMapperInter {
    @Select("SELECT * FROM USER WHERE usernum = #{usernum}")
    UserDto findByUsernum(int usernum);


    //마이페이지 수정
    @Update("UPDATE USER SET usernickname = #{nickname}, userpassword = #{userpassword}, userprofileimage = #{userprofileimage} WHERE usernum = #{usernum}")
    int updateUser(UserDto userdto);

    @Select("SELECT userpassword FROM USER WHERE useremail = #{useremail}")
    String getPasswordByEmail(@Param("useremail") String useremail);

    //usernum
    @Select("SELECT usernum FROM USER WHERE useremail = #{email}")
    int getUserNumByEmail(String email);

    // 비밀번호 변경 메소드 추가
    @Update("UPDATE USER SET userpassword = #{newPassword} WHERE usernum = #{usernum}")
    boolean changePassword(int usernum, String newPassword);

}
