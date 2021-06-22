package com.atguigu.curd.test;

import com.atguigu.curd.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/resources/dispatcherServlet-servlet.xml"})
public class MVCTest {


    MockMvc mockMvc;
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();

    }

    @Test
    public void est() throws Exception {
        MvcResult pn = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

        MockHttpServletRequest request = pn.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println(pageInfo.getPageNum());
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println(employee);

        }


    }


}
