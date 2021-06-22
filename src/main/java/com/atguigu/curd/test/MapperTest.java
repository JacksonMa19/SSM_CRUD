package com.atguigu.curd.test;

import com.atguigu.curd.bean.Department;
import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.dao.DepartmentMapper;
import com.atguigu.curd.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void test1() {
        //拿到容器哦
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//
//        DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
//        System.out.println(departmentMapper);
//        departmentMapper.insertSelective(new Department(1,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
//        employeeMapper.insertSelective(new Employee(null,"Jackson", "M","jackson@qq.com",1));
//        employeeMapper.insertSelective(new Employee(null,"Jerry", "F","jerry@qq.com",2));

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String substring = UUID.randomUUID().toString().substring(0, 5) + i;

            mapper.insert(new Employee(null, substring, "M", substring+"@qq.com",2));
            
        }


    }
}
