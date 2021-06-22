package com.atguigu.curd.service;

import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.bean.EmployeeExample;
import com.atguigu.curd.dao.DepartmentMapper;
import com.atguigu.curd.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    /**
     * 查询所以员工
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }


    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }


    /**
     * 检验受否可用
     * @param empName
     * @return
     */
    public boolean check(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除员工
     * @param id
     */
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
    }
}
