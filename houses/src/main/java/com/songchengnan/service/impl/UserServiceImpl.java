package com.songchengnan.service.impl;

import com.songchengnan.mapper.UserMapper;
import com.songchengnan.pojo.House;
import com.songchengnan.pojo.User;
import com.songchengnan.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;



    @Override
    public List<House> getAllHouses() {
        log.info("查询所有房源（包括房东和用户）");
        return userMapper.houseAll(); // 复用 houseAll() 方法
    }


    @Override
    public void update(User user) {
        log.info("更新用户信息");
        userMapper.update(user);
    }

    @Override
    public User userInfo(String username) {
        log.info("查询用户信息");
        return userMapper.userInfo(username);
    }

    @Override
    public List<House> userHouse(String username) {
        log.info("查询用户房子");
        return userMapper.userHouse(username);
    }

    @Override
    public House houseDetail(Integer houseid) {
        log.info("查询房子信息");
        return userMapper.houseDetail(houseid);
    }

    @Override
    public void addHouse(House house) {
        log.info("新增房源");
        // 设置房源默认状态为未出租
        house.setStatue(0);
        // 如果房东电话未填写，自动填充房东的电话
        if (house.getHousephone() == null || house.getHousephone().isEmpty()) {
            User user = userMapper.userInfo(house.getHousename());
            if (user != null) {
                house.setHousephone(user.getUserphone());
            }
        }
        // 如果装修信息未填写，设置为默认值
        if (house.getDecoration() == null || house.getDecoration().isEmpty()) {
            house.setDecoration("普通装修"); // 默认装修信息
        }
        userMapper.addHouse(house);
    }


    @Override
    public void deleteHouse(Integer houseid) {
        log.info("删除房源");
        userMapper.deleteHouse(houseid);
    }



    @Override
    public void updateHouse(House house) {
        log.info("更新房源信息: {}", house);
        userMapper.updateHouse(house);
    }



    @Override
    public List<House> houseAll() {
        log.info("查询所有房源");
        return userMapper.houseAll();
    }

    @Override
    public List<House> houseCommunity(String community) {
        log.info("查询小区房源");
        return userMapper.houseCommunity(community);
    }

    @Override
    public void rentalHouse(Integer houseid, String tenantname) {
        log.info("更新房源信息");
        userMapper.rentalHouse(houseid, tenantname);
    }

    @Override
    public void terminateHouse(Integer houseid) {
        log.info("终止房源信息");
        userMapper.terminateHouse(houseid);
    }




}
