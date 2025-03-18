package com.songchengnan.service.impl;

import com.songchengnan.mapper.ContractMapper;
import com.songchengnan.mapper.UserMapper;
import com.songchengnan.pojo.Contract;
import com.songchengnan.service.ContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContractServiceImpl implements ContractService {

    @Autowired
    private ContractMapper contractMapper;

    @Autowired
    private UserMapper userMapper; // 注入 UserMapper

    @Override
    public void addContract(Contract contract) {
        contractMapper.addContract(contract);
    }

    @Override
    public Contract getContractById(Integer contractid) {
        return contractMapper.getContractById(contractid);
    }

    @Override
    public List<Contract> getContractsByUser(String username) {
        return contractMapper.getContractsByUser(username);
    }

    @Override
    public void updateContractStatus(Integer contractid, String status, String adminstatus) { // 修改方法实现
        contractMapper.updateContractStatus(contractid, status, adminstatus);
    }



    @Override
    public List<Contract> getAllContracts() {
        return contractMapper.getAllContracts();
    }

    @Override
    public void updateHouseOwner(Integer houseid, Integer statue, String housename, String tenantname) {
        // 根据新的 housename 查询用户的电话
        String housephone = userMapper.getUserPhoneByUsername(housename);
        // 如果状态为3（已出售/已购买），则更新tenantname为购买者的名字
        if (statue == 3) {
            contractMapper.updateHouseOwner(houseid, statue, housename, tenantname);
        } else {
            // 其他状态的处理
            contractMapper.updateHouseOwner(houseid, statue, housename, null);
        }
        // 更新 housephone
        contractMapper.updateHousePhone(houseid, housephone);
    }

}