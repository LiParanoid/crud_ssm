package com.rytong.crud.service;

import com.rytong.crud.bean.Employee;
import com.rytong.crud.bean.EmployeeExample;
import com.rytong.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Paranoid
 * @create 2018-12-01 15:46
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;


    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        // TODO Auto-generated method stub
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存方法
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     *
     * @param empName
     * @return  true 为用户名可用
     */
    public Boolean checkEmpName(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long l = employeeMapper.countByExample(example);
        return (l == 0);
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;

    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
}
