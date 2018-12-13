package com.rytong.crud.service;

import com.rytong.crud.bean.Department;
import com.rytong.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *
 * @author Paranoid
 * @create 2018-12-13 20:47
 */
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDepts() {
        List<Department> departmentList = departmentMapper.selectByExample(null);
        return departmentList;
    }
}
