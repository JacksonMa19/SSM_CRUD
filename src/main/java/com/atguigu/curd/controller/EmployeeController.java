package com.atguigu.curd.controller;

import com.atguigu.curd.bean.Employee;
import com.atguigu.curd.bean.Msg;
import com.atguigu.curd.service.EmployeeService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.objenesis.instantiator.sun.MagicInstantiator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> employees = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employees, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }


    /**
     * 查询员工数据
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        PageHelper.startPage(pn,5);
        //后面的查询就是分页查询
        List<Employee> emps = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps, 5);

        model.addAttribute("pageInfo", pageInfo);

        return "list";

    }

    /**
     * 保存员工
     * @return
     */
     @RequestMapping(value = "/emp", method = RequestMethod.POST)
     @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
         if (result.hasErrors()) {
             HashMap<String, Object> map = new HashMap<>();
             List<FieldError> fieldErrors = result.getFieldErrors();
             for (FieldError fieldError : fieldErrors) {
                 map.put(fieldError.getField(), fieldError.getDefaultMessage());
             }
             return Msg.fail().add("errorField", map);
         } else {

         }
         employeeService.saveEmp(employee);
         return Msg.success();

    }

    /**
     * 检测昵称是否可用
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmployee")
    public Msg checkEmployee(@RequestParam("empName") String empName) {
        //先得到前端校验的结果
        String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        boolean matches = empName.matches(reg);
        if (!matches) {
            return Msg.fail().add("va_msg", "格式错误：用户名可以2-5个中文或6-16个英文和数字的组合");
        }
        boolean b = employeeService.check(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg","用户名已存在");
        }

    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 员工更新
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee) {
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();

    }

    /**
     * 删除员工数据
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            String[] empIds = ids.split("-");
            ArrayList<Integer> list = new ArrayList<>();
            for (String empId : empIds) {
                list.add(Integer.parseInt(empId));
            }
            employeeService.deleteBatch(list);

        }else {
            int id = Integer.parseInt(ids);
            employeeService.deleteEmpById(id);
        }



        return Msg.success();
    }


}
